using UnityEngine;
using System.Collections;

public class KnightControl : MonoBehaviour {

	private int num1 = 0;
	private int num2 = 0;

	private Animator anim;	
	private FirstPersonControl Player;

	AnimatorStateInfo currentBaseState; 

	public ParticleSystem SwordHitEffect;

	private bool isAttackIn = false;

	// Use this for initialization
	void Start () {
		anim = GetComponent<Animator>();

		Player = GameObject.Find("First Person Controller").GetComponent<FirstPersonControl> ();
		Debug.Log (Player);


	}

	// Update is called once per frame
	void Update () {



	}

	public void Attack(int num){
		Debug.Log ("Attack");
		if (!isAttackIn) {
			anim.SetTrigger ("Attack");
		}



	}

	public bool GetAttackState(){
		return anim.GetBool ("isAttack");
	}

	public void OnWalking(){
		anim.SetBool ("Walk", true);
	}



	public void OffWalking(){
		anim.SetBool ("Walk", false);
		
	}

	public void HandUp(){
		anim.SetBool ("HandUp", true);
	}

	public void HandDown(){
		anim.SetBool ("HandUp", false);
	}


	/*
	 * animation event
	 */

	void AttackIn(){
		isAttackIn = true;
	}

	void AttackOut(){
		isAttackIn = false;
	}

	void AttackStart(){
		anim.SetBool ("isAttack", true);
		Player.PlayAttackSound ();
	}

	void AttackEnd(){
		anim.SetBool ("isAttack", false);
	}



	void CreateEffect(){
		ParticleSystem effect = Instantiate(SwordHitEffect, transform.position + transform.TransformDirection(0,1,3), Quaternion.Euler(0,90,0)) as ParticleSystem;


		//effect.transform.rotation = Quaternion.Euler(90,0,0);
		//effect.transform.localScale = new Vector3 (2, 2, 2);

	}

}
